# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
  raise "@candidates must be an Array" if @candidates.nil?
  @candidates.find do |candidate| 
    id == candidate[:id] 
  end 
end

class InvalidCandidateError < StandardError
end 

def experienced?(candidate)
  unless candidate.has_key?(:years_of_experience)
    raise InvalidCandidateError, "candidate must have a :years_of_experience key"
  end 
  candidate[:years_of_experience] >= 2 
end

def qualified_candidates(candidates)
  candidates.select do |candidate| 
    experienced?(candidate) && github_points?(candidate) && languages?(candidate) &&  age?(candidate) && applied_time?(candidate)
  end
end

def ordered_by_qualifications(candidates)
  candidates.sort do |candidate1, candidate2|
    [-candidate1[:years_of_experience], -candidate1[:github_points]] <=> [-candidate2[:years_of_experience], -candidate2[:github_points]]
  end 
end

#conditions for qualified_candidates 
def github_points?(candidate)
  unless candidate.has_key?(:github_points)
    raise InvalidCandidateError, "candidate must have a :github_points key"
  end
  candidate[:github_points] >=100
end 

def languages?(candidate)
  unless candidate.has_key?(:languages)
    raise InvalidCandidateError, "candidate must have a :languages key"
  end
  candidate[:languages].include?("Ruby" || "Python" )
end 

def age?(candidate)
  unless candidate.has_key?(:age)
    raise InvalidCandidateError, "candidate must have a :age key"
  end
  unless candidate.has_key?(:date_applied)
    raise InvalidCandidateError, "candidate must have a :date_applied key"
  end
  candidate[:age] > 17 && candidate[:date_applied]
end 

def applied_time?(candidate)
  unless candidate.has_key?(:date_applied)
    raise InvalidCandidateError, "candidate must have a :date_applied key"
  end
  candidate[:date_applied] > 15.day.ago.to_date
end 

#REPL-based menu

def repl_menu 
  loop do 
  puts "What would you like to do?"
  puts ">Display candidate with id# (find #)"
  puts ">Display all candidates (all)"
  puts ">Display qualified candidates (qualified)"
  puts ">Exit REPL (quit)"
  input = gets.downcase.chomp
    case input 
    when /^find\s\d+$/
      if find(input[5..-1].to_i) != nil
        puts find(input[5..-1].to_i)
      else 
        puts "Sorry, that candidate does not exist!"
      end 
    when "all"
      puts @candidates
    when "qualified"
      puts qualified_candidates(@candidates)
    when "quit"
      break 
    else 
      puts "Sorry, that is not a command! Please try again."
    end
  end
end