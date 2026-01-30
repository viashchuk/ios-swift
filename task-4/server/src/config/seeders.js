import { Category, Product, User, Order, OrderItem } from '../models/index.js'
import bcrypt from 'bcrypt'


const categoriesData = [
  {
    name: "Frappuccino",
    products: [
      {
        name: "Caramel Brulée Frappuccino",
        details: "Coffee-based blended drink with caramel brulée flavor. Ingredients: coffee, milk, ice, caramel brulée syrup, whipped cream, caramel sugar topping.",
        price: 6.45,
        imageName: "caramel_brulee_frappuccino"
      },
      {
        name: "Peppermint Mocha Frappuccino",
        details: "Refreshing mint and chocolate coffee drink. Ingredients: coffee, milk, ice, mocha sauce, peppermint syrup, whipped cream, chocolate curls.",
        price: 6.75,
        imageName: "peppermint_mocha_frappuccino"
      },
      {
        name: "Peppermint White Chocolate Mocha Frappuccino",
        details: "Smooth white chocolate and peppermint coffee drink. Ingredients: coffee, milk, ice, white chocolate mocha sauce, peppermint syrup, whipped cream.",
        price: 6.85,
        imageName: "peppermint_white_chocolate_mocha_frappuccino"
      },
      {
        name: "Caramel Frappuccino",
        details: "Classic caramel-flavored blended coffee drink. Ingredients: coffee, milk, ice, caramel syrup, whipped cream, caramel drizzle.",
        price: 5.95,
        imageName: "caramel_frappuccino"
      },
      {
        name: "Mocha Cookie Crumble Frappuccino",
        details: "Rich mocha drink with chocolate cookie pieces. Ingredients: coffee, milk, ice, mocha sauce, chocolate cookie crumble, whipped cream.",
        price: 7.15,
        imageName: "mocha_cookie_crumble_frappuccino"
      },
      {
        name: "Mocha Frappuccino",
        details: "Classic chocolate-flavored coffee Frappuccino. Ingredients: coffee, milk, ice, mocha sauce, whipped cream.",
        price: 5.75,
        imageName: "mocha_frappuccino"
      }
    ]
  },
  {
    name: "Refreshers",
    products: [
      {
        name: "Strawberry Açaí Lemonade Refresher",
        details: "Fruity strawberry and açaí drink with lemonade. Ingredients: strawberry açaí base, lemonade, ice, real strawberry pieces.",
        price: 5.25,
        imageName: "strawberry_acai_lemonade_refresher"
      },
      {
        name: "Mango Dragonfruit Lemonade Refresher",
        details: "Tropical mango and dragonfruit lemonade drink. Ingredients: mango dragonfruit base, lemonade, ice, dragonfruit pieces.",
        price: 5.45,
        imageName: "mango_dragonfruit_lemonade_refresher"
      }
    ]
  },
  {
    name: "Coconutmilk Refreshers",
    products: [
      {
        name: "Pink Drink",
        details: "Strawberry açaí refresher with coconutmilk. Ingredients: strawberry açaí base, coconutmilk, ice, freeze-dried strawberries.",
        price: 5.65,
        imageName: "pink_drink"
      },
      {
        name: "Dragon Drink",
        details: "Mango dragonfruit refresher with coconutmilk. Ingredients: mango dragonfruit base, coconutmilk, ice, dragonfruit pieces.",
        price: 5.85,
        imageName: "dragon_drink"
      }
    ]
  }
]

export const seedAll = async () => {
  try {
    let dbCategories = await Category.findAll()
    if (dbCategories.length === 0) {
      await Category.bulkCreate(categoriesData.map(c => ({ name: c.name })))
      dbCategories = await Category.findAll()
    }

    let dbProducts = await Product.findAll()
    if (dbProducts.length === 0) {
      const productsToCreate = []
      categoriesData.forEach(sourceCategory => {
        const matchedDbCategory = dbCategories.find(dbCat => dbCat.name === sourceCategory.name)
        if (matchedDbCategory) {
          sourceCategory.products.forEach(prod => {
            productsToCreate.push({
              name: prod.name,
              description: prod.details,
              price: prod.price,
              categoryId: matchedDbCategory.id,
              imageUrl: prod.imageName
            })
          })
        }
      })
      dbProducts = await Product.bulkCreate(productsToCreate, { returning: true })
    }

    let testUser = await User.findOne({ where: { email: 'vicky@test.com' } })
    if (!testUser) {
      const saltRounds = 10
      const hashedPassword = await bcrypt.hash('123456', saltRounds)

      testUser = await User.create({
        name: "Vicky",
        email: "vicky@test.com",
        password: hashedPassword
      })
    }

    const orderCount = await Order.count()

    if (orderCount === 0) {
      const item1 = {
        productId: dbProducts[0].id,
        quantity: 2,
        price: dbProducts[0].price
      }

      const item2 = {
        productId: dbProducts[1].id,
        quantity: 3,
        price: dbProducts[1].price
      }

      const totalAmount = (item1.quantity * item1.price) + (item2.quantity * item2.price)

      const newOrder = await Order.create({
        userId: testUser.id,
        status: 'initialized',
        paymentMethod: 'card',
        totalAmount: totalAmount
      })

      await OrderItem.bulkCreate([
        {
          orderId: newOrder.id,
          ...item1
        },
        {
          orderId: newOrder.id,
          ...item2
        }
      ])
    }
  } catch (error) {
    console.error(error)
    throw error
  }
}