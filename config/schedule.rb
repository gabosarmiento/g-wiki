every :friday, at => "4am" do
  command "rm -rf #{RAILS_ROOT}/tmp/cache"
  PaperTrail::Version.delete_all ["created_at < ?", 1.week.ago]
end