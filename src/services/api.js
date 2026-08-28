import { createClient } from '@supabase/supabase-js'

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL
const SUPABASE_KEY = process.env.NEXT_PUBLIC_SUPABASE_KEY

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY)

export const productService = {
  getAll: async (params = {}) => {
    let query = supabase.from('products').select('*')

    if (params.search) {
      query = query.or(`name.ilike.%${params.search}%,description.ilike.%${params.search}%`)
    }

    const { data, error } = await query
    if (error) throw error
    return data
  },

  getById: async (id) => {
    const { data, error } = await supabase
      .from('products')
      .select('*')
      .eq('id', id)
      .single()
    if (error) throw error
    return data
  },

  search: async (query) => {
    return productService.getAll({ search: query })
  },
}

export const categoryService = {
  getAll: async () => {
    const { data, error } = await supabase
      .from('categories')
      .select('*')
    if (error) throw error
    return data
  },

  getById: async (id) => {
    const { data, error } = await supabase
      .from('categories')
      .select('*')
      .eq('id', id)
      .single()
    if (error) throw error
    return data
  },
}

export const creditService = {
  getConfig: async () => {
    const { data, error } = await supabase
      .from('credit_config')
      .select('*')
      .limit(1)
      .single()
    if (error) throw error
    return data
  },
}

export const companyService = {
  getConfig: async () => {
    const { data, error } = await supabase
      .from('company_config')
      .select('*')
      .limit(1)
      .single()
    if (error) throw error
    return data
  },
}

export default supabase
