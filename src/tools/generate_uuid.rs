pub fn generate_uuid_v4() -> String {
    uuid::Uuid::new_v4().to_string()
}
