class Paper < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_all,
                  :against => [:title, :author_name, :text],
                  :using => {
                    :tsearch => { :dictionary => "english" }
                  }

  has_attached_file :file
  validates_attachment_content_type :file, :content_type => ["application/pdf"]
  validates_attachment :file,
    :presence => true,
    :content_type => ["application/pdf"],
    :size => { :less_than => 4.megabytes }
end
