Facter.add("vhosts") do
	setcode do
		Facter::Core::Execution.exec('printf ""; if [[ -d /var/www/vhosts/ ]]; then for f in $(find /var/www/vhosts/ -mindepth 1 -maxdepth 1 -type d ); do f="${f#/}"; echo "${f##*/}"; done; fi;')
	end
end

Facter.add("vhosts_full") do
	setcode do
		Facter::Core::Execution.exec('printf ""; if [[ -d /var/www/vhosts/ ]]; then for f in $(find /var/www/vhosts/ -mindepth 1 -maxdepth 1 -type d ); do echo "$f"; done; fi;')
	end
end