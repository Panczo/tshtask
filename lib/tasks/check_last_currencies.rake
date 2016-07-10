desc "Parse last exchange rates"
task :check_last_currencies => :environment do
  puts "Updating last exchange"
  ExchangeWorker.new.perform
  puts "done."
end
