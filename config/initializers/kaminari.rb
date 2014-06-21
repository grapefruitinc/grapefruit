# Fixes bug with Active Admin using pagination
# https://github.com/gregbell/active_admin/wiki/How-to-work-with-will_paginate/ba9ced3205a5b1627aa382870412bae9314092ec

Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end