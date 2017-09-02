Mi-Ke Docs
==========

```
bundle exec jekyll serve
```

[Theme on Github](https://github.com/pages-themes/merlot)

Stylesheet `/assets/css/style.scss` 
Default layout `/_layouts/default.html`

### Previewing the theme locally

If you'd like to preview the theme locally (for example, in the process of proposing a change):

1. Clone down the theme's repository (`git clone https://github.com/pages-themes/merlot`)
2. `cd` into the theme's directory
3. Run `script/bootstrap` to install the necessary dependencies
4. Run `bundle exec jekyll serve` to start the preview server
5. Visit [`localhost:4000`](http://localhost:4000) in your browser to preview the theme

### Running tests

The theme contains a minimal test suite, to ensure a site with the theme would build successfully. 
To run the tests, simply run `script/cibuild`. 
You'll need to run `script/bootstrap` one before the test script will work.
