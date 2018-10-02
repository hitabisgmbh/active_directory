%w[sam_account_type group_type].each do |file_name|
  require "#{Rails.root}/lib/active_directory/attributes/" + file_name
end
