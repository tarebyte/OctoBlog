Spring.watch "spec/factories"
Spring.after_fork do
  ENV['GUARD_NOTIFY'] = 'true'
  ENV['GUARD_NOTIFICATIONS'] = "---\n- :name: :notifysend\n  :options: {}\n"
end
