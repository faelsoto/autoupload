Requerimientos
---

- Ruby 1.9
- listen `gem install listen`
- guard `gem install guard`
- xclip `sudo apt-get install xclip`


Instrucciones
---

1. Clonar el repo
2. Abrir CompizConfig » Screenshot y poner el path hacia la carpeta `uploads/` de autoupload
3. Dar permisos de ejecución a `start.sh` con `chmod +x start.sh`
4. [Obtener una API key de imgur](http://imgur.com/register/api_anon) y ponerla en `@api_key` dentro de `config.rb`
5. Autoiniciar el `start.sh` mediante la interfaz de Startup Applications
