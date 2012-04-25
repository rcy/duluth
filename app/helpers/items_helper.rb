module ItemsHelper
  def item_options_helper(item)
    if item.archive?
      opts = [["",
               [["Closed", item.kind],
                ["Re-open", "do:unarchive"]]]]
    else
      opts = [["Move to:",
               [["Inbox", "inbox"],
                ["Project", "project"],
                ["Action", "action"],
                ["Someday/Maybe", "maybe"],
                ["Waiting For", "waiting"],
                ["Note", "note"],
                ["Calendar", "calendar"]]],
              ["Other",
               [["Close", "do:archive"]]]]
    end
    grouped_options_for_select(opts, item.kind)
  end
end
