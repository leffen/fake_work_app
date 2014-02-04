worker_processes 10 # amount of unicorn workers to spin up
timeout 25         # restarts workers that hang for 20 seconds
preload_app true   # Faster worker spawn times.