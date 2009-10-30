class Tag < ActiveRecord::Base

  def self.top(language_code = 'en', options = {})
    sql = "SELECT tags.name, hits "
    sql << "FROM tags "
    sql << "INNER JOIN top_tags ON tags.id = top_tags.tag_id "
    sql << "INNER JOIN languages ON top_tags.aggregation_id = languages.id "
    sql << "WHERE languages.code = ?"
    sql << "ORDER BY tags.name" 
    Tag.find_by_sql([sql, language_code]);
  end

  def self.overlapping_tags(tags, options = {})
    sql = "SELECT DISTINCT ON (otags.name) otags.name, COUNT(entries.id) AS hits "
    sql << "FROM tags "
    sql << "INNER JOIN entries_tags ON tags.id = entries_tags.tag_id "
    sql << "INNER JOIN entries_tags AS oentries_tags ON entries_tags.entry_id = oentries_tags.entry_id "
    sql << "INNER JOIN tags as otags ON oentries_tags.tag_id = otags.id "
    sql << "INNER JOIN entries ON oentries_tags.entry_id = entries.id "
    sql << "WHERE "
    sql << "GROUP BY oentries_tags.entry_id, otags.name "
    sql << "ORDER BY otags.name" 
    Tag.find_by_sql(sql);
  end
  
  def self.related_tags(language_code = 'en', tags = nil, options = {})
    sql = "SELECT tags.name, COUNT(tags.id) as hits "	
    sql << "FROM entries "
    sql << "INNER JOIN entries_tags ON entries_tags.entry_id = entries.id "
    sql << "INNER JOIN tags ON entries_tags.tag_id = tags.id "
    sql << "INNER JOIN feeds ON entries.feed_id = feeds.id "
    sql << "INNER JOIN languages ON feeds.language_id = languages.id "
    sql << "WHERE languages.code = ? "
    tags.length.times{sql << " AND tags.name != ? "}

    sql << "AND ("
    if tags and tags.length > 0
        sql << "entries.id IN "
        sql << "("
        #The following code finds entries that share the same tags
        sql << "SELECT et.entry_id "
        sql << "FROM entries_tags AS et "
        sql << "INNER JOIN tags t ON t.id = et.tag_id "
        
        tags.length.times{ |counter|
            sql << "INNER JOIN entries_tags AS et" + counter.to_s + " ON et" + counter.to_s + ".entry_id = et.entry_id "
            sql << "INNER JOIN tags t" + counter.to_s + " ON t" + counter.to_s + ".id = et" + counter.to_s + ".tag_id "
        }
        
        sql << "WHERE "
        
        connector = ""
        tags.length.times{ |counter| sql << connector + " t" + counter.to_s + ".name = ? "; connector = " AND "}
        
        sql << ") ) "
    end
    sql << "GROUP BY tags.id, tags.name "
    sql << "ORDER BY name "
    
    add_limit!(sql,options)
    result = Tag.find_by_sql([sql].push(language_code) + tags + tags)
  end
  
  def self.clean_sql(tag)
    tag
  end
end
