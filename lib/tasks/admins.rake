namespace :admins do

  desc "Sets is_admin equal to true for the given User email address"

  task :set, [:email_address] => :environment do |task, args|

    new_admin_user = User.find_by_email(args.email_address)

    if new_admin_user
      new_admin_user.update_attribute(:is_admin, true)
      puts "Set user '#{args.email_address}' to have admin permissions."
    else
      puts "Could not find a user by the email address '#{args.email_address}'."
    end

  end

end
