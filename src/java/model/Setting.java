package model;

/**
 *
 * @author duongvu
 */
public class Setting {

    /*
    id INT PRIMARY KEY,
    name VARCHAR(255),
    value VARCHAR(10),
    setting_type_id INT,
    order INT,
    status VARCHAR(50),
    description TEXT,
     */
    private int id, typeId, order;

    private String name, description, type, status;

    public Setting() {
    }

    public Setting(int id, int typeId, String type, int order, String name, String status, String description) {
        this.id = id;
        this.typeId = typeId;
        this.order = order;
        this.type = type;
        this.name = name;
        this.status = status;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
