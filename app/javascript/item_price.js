window.addEventListener('load', () => {
  console.log("OK");
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    console.log(inputValue);
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 10 / 100 );
    const addProfitDom = document.getElementById("profit");
    addProfitDom.innerHTML = Math.floor(inputValue - (inputValue * 10 / 100) );
  })
});