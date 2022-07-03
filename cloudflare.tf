terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  email = "hamki.do2000@gmail.com"
  api_token= ""
}


data "cloudflare_zone" "isthe_best" {
  name = "isthe.best"
}

resource "cloudflare_record" "test_isthe_best" {
  zone_id = data.cloudflare_zone.isthe_best.id
  name    = "test"
  value   = "192.0.2.1"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "arch_isthe_best" {
  zone_id = data.cloudflare_zone.isthe_best.id
  name    = "arch"
  value   = "173.212.249.129"
  type    = "A"
  proxied = true
}

resource "cloudflare_page_rule" "archisthebest" {
  zone_id = data.cloudflare_zone.isthe_best.id
  target = "arch.isthe.best"
  priority = 1
  actions {
    forwarding_url {
      url = "https://wiki.archlinux.org/title/arch_is_the_best"
      status_code = 301
   }
  }
}

resource "cloudflare_page_rule" "testisthebest" {
  zone_id = data.cloudflare_zone.isthe_best.id
  target = "test.isthe.best"
  priority = 2
  actions {
    forwarding_url {
      url = "https://wiki.archlinux.org/title/arch_is_the_best"
      status_code = 302
    }
  }
}
