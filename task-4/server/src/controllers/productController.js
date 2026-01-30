import ProductRepository from '../repositories/ProductRepository.js';

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
        });
    }
};

const getProductById = async (req, res) => {
    try {
        const product = await ProductRepository.findById(req.params.id);

        if (!product) {
            return res.status(404).json({
                success: false,
                error: 'Product not found'
            });
        }

        res.json({
            success: true,
            product
        });
    } catch (error) {
        console.error('Get product error:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to fetch product'
        });
    }
};

const getProductsByCategoryId = async (req, res) => {
    try {
        const products = await ProductRepository.findByCategoryId(req.params.categoryId);
        res.json({
            success: true,
            products
        });
    } catch (error) {
        console.error('Get products by category error:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to fetch products by category'
        });
    }
};

const getProductsByCategoryName = async (req, res) => {
    try {
        const products = await ProductRepository.findByCategoryName(req.params.categoryName);
        res.json({
            success: true,
            products
        });
    } catch (error) {
        console.error('Get products by category name error:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to fetch products by category name'
        });
    }
};

const searchProducts = async (req, res) => {
    try {
        const { q } = req.query;

        if (!q) {
            return res.status(400).json({
                success: false,
                error: 'Search query is required'
            });
        }

        const products = await ProductRepository.search(q);
        res.json({
            success: true,
            products
        });
    } catch (error) {
        console.error('Search products error:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to search products'
        });
    }
};

export default {
    getAllProducts,
    getProductById,
    getProductsByCategoryId,
    getProductsByCategoryName,
    searchProducts
};