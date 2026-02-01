import ProductRepository from '../repositories/ProductRepository.js'

const getAllProducts = async (req, res) => {
    try {
        const products = await ProductRepository.findAll()
        res.json({
            success: true,
            products
        })
    } catch (error) {
        res.status(500).json({
            success: false,
            error: 'Failed to fetch products'
        })
    }
}

const getProductById = async (req, res) => {
    try {
        const product = await ProductRepository.findById(req.params.id)

        if (!product) {
            return res.status(404).json({
                success: false,
                error: 'Product not found'
            })
        }

        res.json({
            success: true,
            product
        })
    } catch (error) {
        console.error('Get product error:', error)
        res.status(500).json({
            success: false,
            error: 'Failed to fetch product'
        })
    }
}

const getProductsByCategoryId = async (req, res) => {
    try {
        const products = await ProductRepository.findByCategoryId(req.params.categoryId)
        res.json({
            success: true,
            products
        })
    } catch (error) {
        console.error('Get products by category error:', error)
        res.status(500).json({
            success: false,
            error: 'Failed to fetch products by category'
        })
    }
}

const createProduct = async (req, res) => {
    try {
        const { name, details, price, categoryId } = req.body

        if (!name || !price || !categoryId) {
        console.log("ERRRR")
            return res.status(400).json({
                success: false,
                error: 'Name, price, and categoryId are required'
            })
        }

        const newProduct = await ProductRepository.create({
            name,
            details,
            price,
            categoryId
        })

        res.status(201).json({
            success: true,
            product: newProduct
        })
    } catch (error) {
        console.error('Create product error:', error)
        res.status(500).json({
            success: false,
            error: 'Failed to create product'
        })
    }
}

export default {
    getAllProducts,
    getProductById,
    getProductsByCategoryId,
    createProduct
}