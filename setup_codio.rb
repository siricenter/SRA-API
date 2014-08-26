#!/usr/bin/env ruby
def bundle_install
	puts `cd ~/workspace`
	puts `bundle install`
end

def install_postgres
    unless `parts list`.match(/postgresql/)
		puts `parts install postgresql`
    end

	puts `parts start postgresql`
end

def install_mysql
	unless `parts list`.match(/mariadb/)
		puts `parts install mariadb`
	end

	puts `parts start mariadb`
end

def install_mongo
	unless `parts list`.match(/mongodb/)
		puts `parts install mongodb`
	end

	puts `parts start mongodb`
end

def install_phantomjs
	unless `parts list`.match(/phantomjs/)
		puts `parts install phantomjs`
	end
end

def setup_database
    
	#puts `mysql -u root < setup_database.sh`
	#puts `rake db:reset`
	puts `rake db:setup`
    
end

def start_server
	puts `cd ~/workspace`
	puts `ruby app.rb`
end

def get_vimrc
	unless File.exists? "/home/codio/.vimrc"
		`cd ~`
		puts `git clone https://github.com/CJPoll/devenvset`
		puts `mv devenvset/files/default/.vimrc ~`
        puts `mv devenvset/files/default/.tmux.conf ~`
		puts `rm -rf devenvset`
		`cd ~/workspace`
	end
end

def install_vundle
	puts `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim` unless File.directory? "/home/codio/.vim/bundle/"
end

def install_packages
	packages = [
		"ack",
		"tmux"
	]

	packages.each do |package|
		`parts install #{package}`
	end
end

#install_mysql
#install_mongo
bundle_install
install_postgres
install_phantomjs
setup_database
start_server
get_vimrc
install_vundle
install_packages

