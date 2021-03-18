require "spec_helper"

SOLUTION_OUTPUT = <<-OUTPUT 
10 IMG $800
	1 x 10 $800
15 FLAC $1957.50
	1 x 9 $1147.50
	1 x 6 $810
13 VID $2370
	2 x 5 $1800
	1 x 3 $570
OUTPUT

describe "ruby solution.rb" do
  let(:command) { expect { system "ruby solution.rb #{subject}" } }

  describe "10 IMG 15 FLAC 13 VID" do
    specify SOLUTION_OUTPUT do
      command.to output(SOLUTION_OUTPUT)
             .to_stdout_from_any_process
    end
  end

  describe "6 FLAC VID" do
    specify "incomplete input" do
      command.to output(a_string_including("Invalid input missing format code!"))
             .to_stderr_from_any_process
    end
  end
end
