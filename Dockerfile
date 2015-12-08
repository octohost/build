FROM octohost/base:trusty

RUN apt-get install -y curl unzip git wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install ChefDK

RUN wget -q https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.10.0-1_amd64.deb && dpkg -i chefdk_0.10.0-1_amd64.deb && rm -f chefdk_0.10.0-1_amd64.deb

RUN echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile

# Install Packer

RUN mkdir -p /usr/local/bin/ && cd /usr/local/bin && wget -q https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_linux_amd64.zip && unzip packer_0.8.6_linux_amd64.zip && rm -f packer_0.8.6_linux_amd64.zip

RUN git clone https://github.com/octohost/octohost-cookbook.git && cd octohost-cookbook && berks install && berks vendor vendor/cookbooks
