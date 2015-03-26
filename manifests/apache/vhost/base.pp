class server::apache::vhost::base {

	apache::vhost { "${fqdn}":
		servername  => "${fqdn}",
		docroot     => '/var/www/',
		port => '80',
		rewrites    => [
			{
				comment      => 'Rewrite www to non www',
				rewrite_cond => ['%{HTTP_HOST} ^www\.(.*)$ [NC]'],
				rewrite_rule => ['^(.*)$ http://%1/$1 [R=301,L]'],
			},
		],
		setenvif    => [
			'X-Forwarded-For "^$" direct',
			'X-Forwarded-For "^.*\..*\..*\..*" forwarded',
		],
		access_logs => [
			{
				file    => 'access.log',
				format  => '[D] %V %h %t \"%r\" %>s %b \"%{User-Agent}i\"',
				env     => 'direct',
			},
			{
				file    => 'access.log',
				format  => '[P] %V %{X-Forwarded-For}i %t \"%r\" %>s %b \"%{User-Agent}i\"',
				env     => 'forwarded',
			},
		],
		notify      => Service['httpd'],
	}
}