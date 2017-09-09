pkg-smartmontools:
  pkg.installed:
    - name: smartmontools


svc-smartd:
  service.running:
    - name: smartd
    - enable: True
    - requires:
      - pkg: pkg-smartmontools
      - file: cfg-smartd
    - watch:
      - pkg: pkg-smartmontools
      - file: cfg-smartd

cfg-smartd:
  file.managed:
    - name: /etc/smartmontools/smartd.conf
    - source: salt://smartmontools/files/smartd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - requires:
      - pkg: pkg-smartmontools
