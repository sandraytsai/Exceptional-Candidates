# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require './candidates'
require './filters'

## Your test code can go here


# binding.pry
# puts experienced? ({
#     id: 7,
#     years_of_experience: 1,
#     github_points: 145,
#     languages: ['JavaScript', 'Ruby', 'Go', 'Erlang'],
#     date_applied: 15.days.ago.to_date,
#     age: 19
#     })

# puts find 7

# puts qualified_candidates(@candidates)

# # puts ordered_by_qualifications(@candidates)

repl_menu 