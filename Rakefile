task :default => [:development]

task :development do
	sh "unicorn -l 127.0.0.1:8080 -E development"
end

task :production do
	sh "sudo unicorn -l 127.0.0.1:80 -E production -D"
end

task :location, [:path] do |t, args|
	args.with_defaults(:path => "$HOME/Movies")

	public_path = File.join(File.dirname(__FILE__), "public")

	sh "ln -sf #{args.path} #{public_path}"
end