require 'erb'

project_dir = File.expand_path(File.dirname(__FILE__))

p project_dir

compose_file_path = File.join(project_dir, 'docker-compose.yml')

systemd_file = ERB.new(File.read(File.join(project_dir, 'templates/kafka_rest.service.erb'))).result(binding)

File.write('/etc/systemd/system/kafka_rest.service', systemd_file)

system('systemctl daemon-reload')

system('systemctl enable kafka_rest.service')
system('systemctl stop kafka_rest.service')
system('systemctl start kafka_rest.service')

