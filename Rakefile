task :default => [:development]

task :development do
	sh "unicorn --env development"
end

task :production do
	sh "sudo unicorn --port 80 --env production --daemonize"
end

task :location, [:path] do |t, args|
    
    target = File.join(File.dirname(__FILE__), "public")
    source = args[:path] || File.join(Dir.home(), "Movies/")

    if File.exists?(target)
        File.unlink(target)
    end

    FileUtils.ln_sf(source, target)
end
