class ItemsController < ApplicationController
  before_filter :authenticate_user!

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
      format.json { render json: @items }
      format.text { render file: "items/items.txt.erb" }
    end
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
        format.html { redirect_to :items, notice: 'Item was successfully created.' }
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
