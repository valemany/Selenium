

#RSpec to run all thespecs in the case where you try to run a filtered list of specs but no specs match that filter. 
RSpec.configure { |c| c.run_all_when_everything_filtered = true }