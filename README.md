# No-IP Linux DUC for Docker

## Description
The No-IP update client for Docker is a handy tool that automates the process of keeping your dynamic IP address in sync with your No-IP hostname(s). In simpler terms, it helps you make sure that your domain name (like camera.ddns.net) always points to your current IP address.

This docker image is based on our Official Linux DUC version 3, which you can read more about [here](https://www.noip.com/support/knowledgebase/install-linux-3-x-dynamic-update-client-duc/).

## Getting Started
1. Pull the docker container from Github Container Registry (GHCR)

`docker pull ghcr.io/noipcom/noip-duc:latest`

2. Create an .env file (e.g. noip-duc.env) in a safe place, which includes your No-IP credentials. 

For security and convenience, it's best to store your No-IP credentials in an environment file (.env) rather than entering them directly in the command line. Since you are storing sensitive information here, make sure you set the permissions appropriately, ideally `0600`.

These environment variables can be passed to docker with [--env-file](https://docs.docker.com/engine/reference/commandline/run/#env) or to docker-compose as [env_file:](https://docs.docker.com/compose/environment-variables/set-environment-variables/). Docker compose will also look for .env file in the same directory.

Example configuration file (noip-duc.env):
```
# noip-duc.env with DDNS Key
NOIP_USERNAME=DdnsKeyUser
NOIP_PASSWORD=DdnsKeyPass
NOIP_HOSTNAMES=all.ddnskey.com
```

Make sure to replace `DdnsKeyUser`, `DdnsKeyPass`, and the hostnames with your actual No-IP account credentials and hostname or `all.ddnskey.com` if you are using a DDNS Key.

3. Run the Docker container with the environment file with the following command:

`docker run -d --env-file noip-duc.env --name noip-duc ghcr.io/noipcom/noip-duc:latest`

Note: There are additional Environment Variables which can be viewed by running `docker run noip-duc --help`.

### DDNS Keys
[DDNS Keys](https://www.noip.com/support/knowledgebase/how-to-setup-and-use-a-ddns-key) are a feature introduced by No-IP to make updating a hostname more secure. It works by creating a brand new, randomly generated username and password for each hostname.

Once you have [created](https://www.noip.com/support/knowledgebase/how-to-setup-and-use-a-ddns-key) a DDNS Key, you will need to include your credentials in your configuration file. For example, if your DDNS Key Username is `yf5f8n5` and your DDNS Key Password is `gHil56Bu`, your configuration file should look like this: 

```
# noip-duc.env with DDNS Key
NOIP_USERNAME=yf5f7n5
NOIP_PASSWORD=gHil56Bu
NOIP_HOSTNAMES=all.ddnskey.com
```

Note that with DDNS Keys, you do NOT need to specify a hostname in your configuration. The hostname `all.ddnskey.com` is used for ALL DDNS Keys.

### Groups
No-IP's [Groups](https://www.noip.com/support/knowledgebase/limit-hostnames-updated-dynamic-dns-client/) is an older, legacy version of DDNS Keys. We are working to push new users to use DDNS Keys, but if you already have Groups configured, you are welcome to use them with the Linux DUC.

Simply include the groupname, username and password, along with the hostname you want to update in the docker command or the ENV file.

For example, if you created a group named `mygroup`, and your No-IP account username was `myusername`, your username in the configuration file should look like: `mygroup:myusername`

Enter the group password you set as your password, and specify the hostname you want to update. It must be selected in your Groups configuration to update correctly.

```
# noip-duc.env with Groups
NOIP_USERNAME=mygroup:myuser
NOIP_PASSWORD=GroupPassword
NOIP_HOSTNAMES=myhostname.ddns.net
```

### IPv6
To update your host to an IPv6 address you will need to create a new hostname as an AAAA (IPv6) type. You can read more about that [here](https://www.noip.com/support/knowledgebase/automatic-ipv6-updates-linux-duc)

To enable No-IP's IPv6 update method add the following line to your ENV file:

`IP_METHOD=http://ip1.dynupdate6.no-ip.com/`

### Help
There are more options available in the Linux DUC that we will not cover here. To see all available options, run the following command in your terminal:

`docker run noip-duc --help`

## Frequently Asked Questions (FAQ)

### How do I check if the update client is working?
You can verify the update client's status by checking the container logs. Use this command to see the logs:

`docker logs noip-duc`

### How do I update my No-IP credentials?
If you need to change your No-IP credentials or hostname, simply update your environment file with the new values and restart the container using:

`docker restart noip-duc`

## Need help?
Encountered a problem or have questions? Check our Github Issues page for previously reported bugs, and don't hesitate to create a [Support Ticket](https://www.noip.com/ticket). We're here to help you out!

## Contribution
We love open-source and welcome any contributions. If you find a bug or want to suggest an improvement, feel free to create a pull request or an issue. Or you can always send your feedback to our support team at support@noip.com. 
