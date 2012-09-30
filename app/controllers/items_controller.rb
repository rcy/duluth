class ItemsController < ApplicationController
  before_filter :authenticate_user!

  def ajax_index
    @items = Item.active(current_user)
  end

  # GET /items
  # GET /items.json
  def index
    @item = Item.new

    if params[:kind] && params[:kind] != 'all'
      opts = {:kind => params[:kind]}
    else
      opts = {}
    end

    @items = Item.active(current_user).where(opts)
    if params[:context]
      @items = @items.where("summary LIKE '%#{params[:context]}%'")
    end

    @contexts = Item.contexts(current_user)

    @count = {}
    [:inbox, :action, :project, :waiting, :maybe, :note, :calendar].each do |kind|
      @count[kind] = Item.active(current_user).where(:kind => kind).count
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items, callback: params[:callback] }
      format.text { render file: "items/items.txt.erb" }
      format.csv { send_data(Item.csv(@items),
                             :type => 'text/csv',
                             :filename => "#{current_user.nick}_#{params[:kind]}_#{params[:context]}.csv") }
    end
  end

  def token
    if request.post?
      current_user.reset_authentication_token!
      redirect_to token_path
      return
    else
      current_user.ensure_authentication_token!
    end

    @token = current_user.authentication_token
    respond_to do |format|
      format.html
    end
  end

  def import
    if request.post?
      tmp = params[:file_upload][:my_file].tempfile
      user_id = current_user.id
      CSV.foreach(tmp.path, :headers => true) do |row|
        attrs = row.to_hash
        existing = current_user.items.find_by_summary attrs['summary']

        if existing.present?
          existing.update_attributes attrs
        else
          current_user.items.create! attrs
        end
      end
      redirect_to :items
    end
  end

  def export
    items = Item.every(current_user)
    filename = "duluth_items_#{current_user.nick}.csv"

    send_data(Item.csv(items), :type => 'text/csv', :filename => filename)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html { render layout: false }# show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    @item.user = current_user

    respond_to do |format|
      if @item.save
        format.html { redirect_to request.referer, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { render partial: 'item', locals: { item: @item } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.archive = true
    @item.save!

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Destroyed item.' }
      format.json { head :no_content }
    end
  end
end
