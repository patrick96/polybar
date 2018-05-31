// We exclude everyone from the list that is already mentioned in CONTRIBUTORS.md
exclude = [
  "jaagr",
  "NBonaparte",
  "skystrife",
  "patrick96",
  "Tobaloidee"
]

data.sort(function(a, b) {
  return b.contributions - a.contributions ;
});

for (contr of data) {
  if(exclude.includes(contr.login)) {
    continue;
  }

  print(contr.login + "\t" + contr.html_url + "\t" + contr.contributions + "\t" + contr.url);
}
