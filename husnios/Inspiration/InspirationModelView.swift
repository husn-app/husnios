let sampleSubInspiration = SubInspiration(
    name: "Sample SubInspiration",
    query: "sample query",
    product: sampleProduct
)

let sampleInspiration = Inspiration(
    category: "Sample Category",
    subInspirations: Array(repeating: sampleSubInspiration, count: 8)
)

let sampleInspirations = Array(repeating: sampleInspiration, count: 12)
