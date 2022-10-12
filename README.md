# Decidim Privacy

Il componente aggiunge la possibilità di personalizzare opzioni di privacy a livello di organizzazine e/o di singolo utente.
Sviluppata da [Kapusons](https://www.kapusons.it) per la versione v0.25.2 di Decidim. Dipende dalle gemme [decidim](https://github.com/decidim/decidim/tree/v0.25.2) e [deface](https://github.com/spree/deface#readme).

## Come usare

Nel backoffice, nei Settings viene aggiunta una voce di menu "Privacy Module" che permetterà di editare le configurazioni a livello di 
organizzazione per tutti gli utenti:
1. Enable user avatar upload: permettere di rimuovere all'utente la possibilità di caricare un avatar.
2. Enable user && comment search: rimuove dai risultati di ricerca gli utenti e i commenti.
3. Enable user follow: disabilita la possibilità di seguire utenti.
4. Enable user index: permette di disabilitare l'indicizzazione dei motori di ricerca nelle pagine pubbliche.
5. Enable user public page: disabilita la visualizzazione della pagina "Activity".

Nel frontend, in My account viene aggiunta una voce di menu "My Privacy" che permetterà di editare le configurazioni a livello di singolo utente:
1. Enable user && comment search: rimuove dai risultati di ricerca se stesso utenti e i relativi commenti.
2. Enable user index: permette di disabilitare l'indicizzazione dei motori di ricerca nelle pagine pubbliche.
3. Enable user public page: disabilita la visualizzazione agli altri utenti della pagina "Activity".

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

## Contributing
https://github.com/kapusons/decidim-module-privacy/graphs/contributors

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).