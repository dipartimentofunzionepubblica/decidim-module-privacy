# Decidim Privacy

Il componente aggiunge la possibilità di personalizzare opzioni di privacy a livello di organizzazine e/o di singolo utente.
Dipende dalle gemme [decidim](https://github.com/decidim/decidim/tree/v0.25.2) e [deface](https://github.com/spree/deface#readme).

## Come usare

Nel backoffice, nei Settings viene aggiunta una voce di menu "Privacy Module" che permetterà di editare le configurazioni a livello di 
organizzazione per tutti gli utenti:
1. Abilita/Disabilita l'upload dell'avatar agli utenti.
2. Abilita/Disabilita la ricerca del profilo utente e dei relativi commenti.
3. Abilita/Disabilita la possibiltà di seguire gli utenti.
4. Abilita/Disabilita la possibiltà di inviare messaggi privati agli utenti. Le conversazioni con gli admin rimangono comunque possibili.
5. Abilita/Disabilita l'indicizzazione dei motori di ricerca sulle pagine pubbliche.
6. Abilita/Disabilita la visualizzazione della pagina "Attività" agli altri utenti.

Nel frontend, in My account viene aggiunta una voce di menu "My Privacy" che permetterà di editare le configurazioni a livello di singolo utente:
1. Abilita/Disabilita la ricerca del profilo utente e dei relativi commenti.
2. Abilita/Disabilita l'indicizzazione dei motori di ricerca sulle pagine pubbliche.
3. Abilita/Disabilita la visualizzazione della pagina "Attività" agli altri utenti.

## Installazione

Aggiungi questa linea al Gemfile

```ruby
gem "decidim-privacy"
```

Ed esegui:

```bash
bundle install
bundle exec rails decidim_privacy:install:migrations
bundle exec rails db:migrate
```

Di default tutte le configurazioni hanno valore `true` e quindi il comportamento di decidim non cambia.

## Contributori
Gem sviluppata da [Kapusons](https://www.kapusons.it) per [Formez PA](https://www.formez.it). Per contatti scrivere a maintainer-partecipa@formez.it.

## Segnalazioni sulla sicurezza
La gem utilizza tutte le raccomandazioni e le prescrizioni in materia di sicurezza previste da Decidim e dall’Agenzia per l’Italia Digitale per SPID. Per segnalazioni su possibili falle nella sicurezza del software riscontrate durante l'utilizzo preghiamo di usare il canale di comunicazione confidenziale attraverso l'indirizzo email security-partecipa@formez.it e non aprire segnalazioni pubbliche. E' indispensabile contestualizzare e dettagliare con la massima precisione le segnalazioni. Le segnalazioni anonime o non sufficientemente dettagliate non potranno essere verificate.

## Licenza
Vedi [LICENSE-AGPLv3.txt](LICENSE-AGPLv3.txt).