namespace :db do
  namespace :seed do
    Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb').intern    
      task therms_and_readings: :environment do
        load(filename) if File.exist?(filename)
      end
    end
  end
end
