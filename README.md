## esx_peds 
Dans ce script vous retrouverez deux peds. 
Un ped qui sera un vendeur devant un magasin ou vous pourrez insérer tous les items que vous le souhaitiez.
Et un autre ped qui sera dealer caché dans un bâtiment ou vous pourrez aussi insérer tous les items que vous le souhaitiez. 

## Ajouter un item
Pour rajouter un item, ajouter dans le `config.lua` dans la partie `ItemsForSellerPed = {}` pour le vendeur et dans la partie `ItemsForDealerPed = {}` pour le dealer :
```
{ name = '', label = '', price =  },
```
Exemple :
```
{ name = 'bread', label = 'Pain', price = 10 },
```

## Téléchargement & Installation
Pour l'utiliser, vous devez modifier la configuration en fonction de vos besoins. Comme c'est maintenant pour moi. (`config.lua`)

## Informations
## Utilisant git
```
cd resources
git clone https://github.com/mg-project0/esx_peds [esx]/esx_peds
```

## Manuellement
- Téléchargé https://github.com/mg-project0/esx_peds
- Mettez le dans le dossier `[esx]`

## Installation
- Ajouter dans votre `server.cfg` :

```
start esx_peds
```

# Legal
### License
esx_peds - MG Project (mg-project0)

Copyright (C) 2015-2018 Jérémie N'gadi

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
