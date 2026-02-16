{ vars, ... }:
{
  networking.hostName = "${vars.networkingHostName}";
  networking.networkmanager.enable = true;

  networking.nameservers = [
    "1.1.1.1#one.one.one.one"
    "1.0.0.1#one.one.one.one"
    "2606:4700:4700::1111#one.one.one.one"
    "2606:4700:4700::1001#one.one.one.one"

  ];

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = true;
      MulticastDNS = false;
      DNSSEC = false; # NOTE: wake me up in 20 years when DNSSEC is at least partially working
      LLMNR = false;
      FallbackDNS = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };

}
