#!/bin/bash
#
#Plugin generator for rutorrent
# variables couleurs
CSI="\033["
END="${CSI}0m"
GREEN="${CSI}1;32m"
BLUE="${CSI}1;34m"

# variables 
echo -e "${BLUE} Bienvenue dans l'installation de plugin générator.$END" 
echo ""
echo -e "${GREEN}Nom du dossier du futur plugin.$END"
read NAME
echo""
if [ -d /var/www/rutorrent/plugins/$NAME ]; then
echo "Le répertoire existe, voulez-vous le supprimer? y/n."
rm -rI /var/www/rutorrent/plugins/$NAME
echo ""
fi
echo -e "${GREEN}Destination url du plugin.$END"
read URL
echo ""
echo -e  "${GREEN}Télécharger l'image depuis internet y/n.$END"
read VALIDE
        if [ "$VALIDE" = "n" ];
		then	
echo ""
echo -e "${GREEN}Taper l'url de l'image pour le thème par défaut de ruTorrent.$END"
read IMG
echo ""
echo -e "${GREEN}Taper l'url de l'image pour le thème oblivion de ruTorrent.$END"
read IMGOBLIVION
echo ""
		fi
		
        if [ "$VALIDE" = "y" ];
                then
echo -e "${GREEN}taper l'url de l'image pour le thème par défaut de ruTorrent.$END"
read IMG
echo ""
echo -e "${GREEN}taper l'url de l'image pour le thème oblivion de ruTorrent.$END"
read IMGOBLIVION
echo ""
		fi
		
# creation des dossiers et téléchargements/copies des images
mkdir -p /var/www/rutorrent/plugins/$NAME/lang/
mkdir /var/www/rutorrent/plugins/$NAME/images/
cp -r /tmp/linkgeneratorplugin/images/ /var/www/rutorrent/plugins/$NAME/
        if [ "$VALIDE" = "y" ];
                then
ext=${IMGOBLIVION##*.}
cd /var/www/rutorrent/plugins/$NAME/images/
wget $IMG -O $NAME.$ext
wget $IMGOBLIVION -O $NAME"oblivion".$ext
		fi
		
        if [ "$VALIDE" = "n" ];
                then
ext=${IMGOBLIVION##*.}
cp /var/www/rutorrent/plugins/$NAME/images/$IMG /var/www/rutorrent/plugins/$NAME/images/$NAME.$ext
cp /var/www/rutorrent/plugins/$NAME/images/$IMGOBLIVION /var/www/rutorrent/plugins/$NAME/images/$NAME"oblivion".$ext
		fi
		
# init.js
cat << EOF > /var/www/rutorrent/plugins/$NAME/init.js
/* URL de  Subsonic sur le serveur */
var url = '$URL';

plugin.loadLang(true);
if (theWebUI.theme) {
  if (theWebUI.theme == 'Oblivion') {
    plugin.loadCSS("@NAME@oblivion");
  } else {
    plugin.loadCSS("$NAME");
  }
} else {
  plugin.loadCSS("$NAME");
}

plugin.onLangLoaded = function()
{
  this.addButtonToToolbar("$NAME", theUILang.$NAME, "window.open('"+url+"')", "help");
  this.addSeparatorToToolbar("help");
}
EOF
sed -i "s/@NAME@/$NAME/g;" /var/www/rutorrent/plugins/$NAME/init.js

# gestion css
cat <<EOF > /var/www/rutorrent/plugins/$NAME/$NAME.css
div#t div#$NAME {background: transparent url(./images/$NAME.$ext) no-repeat 0px center}
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/"$NAME"oblivion.css
div#t div#$NAME {background: transparent url(./images/@NAME@oblivion.$ext) no-repeat 0px center}
EOF
sed -i "s/@NAME@/$NAME/g;" /var/www/rutorrent/plugins/$NAME/"$NAME"oblivion.css

# infos plugin
cat <<EOF > /var/www/rutorrent/plugins/$NAME/plugin.info
plugin.description: Plugin Générator for rutorrent
plugin.author: Dude
plugin.runlevel: 11
plugin.version: 1.00
rtorrent.remote: error
need_rtorrent: 0
plugin.help: http://mondedie.fr
EOF

# langues
cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/cs.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/da.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/de.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/el.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/en.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/es.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/fi.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/fr.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/hu.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/it.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/lv.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/nl.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/pl.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/pt.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/ru.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/sk.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/sr.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/sv.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/tr.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/uk.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/vi.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/zh-cn.js
theUILang.$NAME = "$NAME";
EOF

cat <<EOF > /var/www/rutorrent/plugins/$NAME/lang/zh-tw.js
theUILang.$NAME = "$NAME";
EOF
