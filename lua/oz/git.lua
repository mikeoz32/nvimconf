local git_ok, git = pcall(require,"neogit")

if not git_ok then
  print "NeoGit is not installed correctly"
  return
end

git.setup {}
