task :default => [:development]

task :development do
	sh "unicorn -l 0.0.0.0:8080 -E development"
end

task :production do
	sh "sudo unicorn -l 0.0.0.0:80 -E production -D"
end

task :location, [:path] do |t, args|
    
    target = File.join(File.dirname(__FILE__), "public")
    source = args[:path] || File.join(Dir.home(), "Movies/")

    if File.exists?(target)
        File.unlink(target)
    end

    FileUtils.ln_sf(source, target)
end