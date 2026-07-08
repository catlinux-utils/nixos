{ vars, ... }:
{
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
