import CategoryRepository from '../repositories/CategoryRepository.js'

const getAllCategories = async (req, res) => {
    try {
        const categories = await CategoryRepository.findAll()
        res.json({
            success: true,
            categories
        })
    } catch (error) {
        res.status(500).json({
            success: false,
            error: 'Failed to fetch categories'
        })
    }
}

export default {
    getAllCategories,
}