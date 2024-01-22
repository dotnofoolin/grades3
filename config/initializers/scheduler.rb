require 'rufus-scheduler'

unless defined?(Rails::Console) || Rails.env.test?
  # Use a lockfile to prevent every thread of the main process from running the schedules
  lockfile = "#{Rails.root}/tmp/scheduler.lock"

  scheduler = Rufus::Scheduler.new(lockfile: lockfile)

  unless scheduler.down?
    first_at = Time.parse('07:00:00')
    first_at = first_at + 1.day if Time.now > first_at
    scheduler.every '12h', first_at: first_at do
      HacImporter.new.import
    end
  end
end
