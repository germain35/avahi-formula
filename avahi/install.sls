{% from "avahi/map.jinja" import avahi with context %}

avahi_packages:
  pkg.installed:
    - pkgs: {{ avahi.pkgs }}
