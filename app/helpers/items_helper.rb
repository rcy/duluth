module ItemsHelper
  def item_options_helper(item)
    grouped_options_for_select([["Move to:",
                                 [["Inbox", "inbox"],
                                  ["Project", "project"],
                                  ["Next Action", "action"],
                                  ["Someday/Maybe", "maybe"],
                                  ["Note", "trivia"],
                                  ["Calendar", "calendar"]]],
                                ["Other",
                                 [item.archive? ? ["Unarchive", "do:unarchive"] : ["Archive", "do:archive"]]]],
                               item.kind)
  end
end
