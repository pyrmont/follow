# The dev rake task does everything needed to setup an application to work in development
# mode for a new developer.
#
# Running `rake dev:setup` should be all you need to get a new application running.
#
# (This set of tasks is based on Mikel Lindsaar's <https://github.com/reInteractive/default_readme/blob/master/dev.rake>,
#  demo'd at Rorosyd Aug 2012.)
namespace :dev do

  desc "Basic development setup process"
  task :setup do
    Rake::Task["dev:config_files"].invoke
    Rake::Task["dev:generate_secret"].invoke
    Rake::Task["dev:nuke"].invoke
  end

  # Nukes the database completely and re builds it using any seed file that is present.
  task :nuke do
    if Rails.env.production?
      raise StandardError, "You probably didn't mean to nuke the production database"
    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    if File.exist?(Rails.root.join('config/schema.rb'))
      Rake::Task["db:schema:load"].invoke
    end
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    Rake::Task["db:test:clone"].invoke
  end

  # Creates the needed config files for the system to start.
  desc "Set up config/*.yml and .env from the examples"
  task :config_files do
    copy_example = proc do |example, target|
      if File.exist? target
        puts "File already exists: #{target}"
      else
        puts `cp -v "#{example}" "#{target}"`
      end
    end

    # config/*.example.yml
    example_ymls = Dir[File.join(Rails.root, 'config/*.example.yml')]
    example_ymls.each do |example|
      target = example.sub(/\.example\.yml\Z/, '.yml')
      copy_example.call example, target
    end

    # .env-example
    example_env = File.join(Rails.root, '.env-example')
    copy_example.call example_env, example_env.sub(/-example\Z/, '')
  end

  # Loads the .env file and generates a new Rails secret key
  desc "Generate the Rails secret for .env"
  task :generate_secret do
    file = File.join Rails.root, '.env'
    raise "No .env found" unless File.exist? file

    require 'securerandom'
    secret = SecureRandom.hex(64) # See railties-3.2.11/lib/rails/tasks/misc.rake

    env = File.read file
    File.open(file, 'w') do |f|
      f.puts env.sub(/^(RAILS_SECRET)=.*$/, "\\1=#{secret}")
    end
  end

end
