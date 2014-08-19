#!/usr/bin/env ruby
def bundle_install
	puts `cd ~/workspace`
	puts `bundle install`
end

def install_mysql
	unless `parts list`.match(/mariadb/)
		puts `parts install mariadb`
	end

	puts `parts start mariadb`
end


def setup_database
	puts `mysql -u root < setup_database.sh`
	puts `rake db:reset`
end

def start_server
	puts `cd ~/workspace`
	puts `rails server -d`
end



def install_vundle
	puts `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim` unless File.directory? "/home/codio/.vim/bundle/"
end



install_mysql
bundle_install
setup_database
start_server
install_vundle

