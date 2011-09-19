def init
  super
  sections.last.delete(:source)
  sections.last.push(:blame)
end

def git_blame(file)
  git_bin = "git" # TODO: configurability?
  cmd = "#{git_bin} blame -p #{file}"
  puts cmd
  output = %x{#{cmd}}
  commits = {}
  blames = []
  output.split("\n").each do |line|
    if md = line.match(/^([0-9a-f]{39,40})\s\d+\s(\d+).*/)
      line_no = md[2].to_i
      sha = md[1].match(/^0+$/) ? "-" : md[1]

      commits[sha] ||= Commit.new(sha)
      blames[line_no - 1] = commits[sha]
    elsif line =~ /^author (.*)/
      blames.last.author = $1 unless $1 == "Not Committed Yet"
    elsif line =~ /^author-mail (.*)/
      blames.last.mail = $1 unless $1 == "<not.committed.yet>"
    elsif line =~ /^author-time (\d*)/
      blames.last.time = Time.at($1.to_i)
    elsif line =~ /^summary (.*)/
      blames.last.summary = $1
    end
  end
  blames
end

class Commit < Struct.new(:sha, :author, :mail, :time, :summary)
end
