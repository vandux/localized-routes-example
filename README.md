# Rails Internationalization Example
## Goals

This application demonstrates implementation of internationalization configuration and provides a related set of features.

This application should conform to International SEO best pratices outlined here:
* https://moz.com/learn/seo/international-seo
* https://developers.google.com/search/docs/advanced/crawling/international-overview
### Features

* Scoped routing
* Redirection based on `Accept-Language` header
* Labels
* Language picker
* `link` tag alternate `hreflang` attributes (https://developers.google.com/search/docs/advanced/crawling/localized-versions)
* `html` tag `lang` attribute (https://www.w3schools.com/tags/att_global_lang.asp)
* TODO: `Link` http headers (https://developers.google.com/search/docs/advanced/crawling/localized-versions#http)
* TODO: rake task to populate sitemap.xml (https://developers.google.com/search/docs/advanced/crawling/localized-versions#sitemap)
* TODO: database level localization
#### Scoped Routing
Routes without a locale scope should default to the configured default, in this case English. If a locale scope is present, it should set the locale for the request context, resulting in localized labels and link paths.

* English is default language
* Paths without a locale are the default language (ex. `/pages/one`)
* Non-english locale should be present in the page path (ex. `/es/pages/one`)
* Links respect scoped route
  * All links on `/es/pages/one` should have `/es/` scope present in path
* Unsupported languages produce 404 (ex. `/ko/pages/one` or `/en-GB/pages/one`)

#### Redirection
When no locale is present in the path the application should parse `Accept-Language` header to determine user's preference and redirect to appropriate locale.

* IF there is no locale present in the path
* AND `Accept-Language` header is present
* AND `Accept-Language` header preference is not english
* AND `Accept-Language` header preference is includes a valid language
* THEN 302 redirect to path with appropriate locale
* ELSE it will ignore the `Accept-Language` header
#### Labels

* Labels are loaded from appropriate locale
* Missing labels fallback to english (es => en)
* Missing labels with locale fallback to language (es-MX => es)

#### Language Picker
A user can select their language preference, which will redirect them to the appriopriate scoped path.
Their language context is retained throughout the experience without cookies or redirects, instead all links include the scoped path.

* Dropdown with all available languages
* Selecting a language navigates browser to current page in selected language

#### HREFLANG tags
Link tags should exist for instructing crawlers how to find versions of the page in alternate languages.

* `link` tag alternate `hreflang` attributes (https://developers.google.com/search/docs/advanced/crawling/localized-versions)
#### HTML lang attribute
Although attribute is [ignored by Google](https://www.woorank.com/en/edu/seo-guides/best-practices-for-language-declaration), it should still be set as it could be used by screen readers.

* The `lang` attribute on the `html` tag should be set appropriately
* The value should conform to [ISO 639-1 language codes](https://www.w3schools.com/tags/ref_language_codes.asp).

#### Content-Language meta
Deprecated and will not be included.

* `meta` tag type `content-language` attributes

## Setup
Standard Ruby on Rails application with PostgreSQL and Webpacker.

```
bundle install
bundle exec rails db:setup
bundle exec rails db:migrate
bundle exec rails s
```