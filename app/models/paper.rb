class Paper < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_all,
                  :against => [:title, :author_name, :text],
                  :using => {
                    :tsearch => { :dictionary => "english" }
                  }
end
