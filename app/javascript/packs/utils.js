function toCurrency(number) {
  return new Intl.NumberFormat('es-MX',
    {
      currency: 'MXN',
      style: 'currency',
      useGrouping: true
    }).format(number)
}

module.exports = {
  toCurrency: toCurrency
}