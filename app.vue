<template>
  <div>
    <h1>Todo-List</h1>
    <ul>
      <li v-for="todo in todos" :key="todo">
        {{ todo }}
        <button @click="removeTodo(todo)">Remove</button>
      </li>
    </ul>
    <input v-model="newTodo" placeholder="Add a new todo" />
    <button @click="addTodo">Add Todo</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRuntimeConfig } from '#imports';

const config = useRuntimeConfig();
const todos = ref([]);
const newTodo = ref('');

onMounted(async () => {
  await fetchTodos();
});

async function fetchTodos() {
  try {
    const response = await fetch(`${config.public.backendUrl}`);
    if (response.ok) {
      todos.value = await response.json();
    } else {
      console.error('Failed to fetch todos:', response.statusText);
    }
  } catch (error) {
    console.error('Error fetching todos:', error);
  }
}

async function addTodo() {
  if (!newTodo.value) return;

  try {
    const response = await fetch(`${config.public.backendUrl}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ todo: newTodo.value })
    });
    if (response.ok) {
      todos.value.push(newTodo.value);
      newTodo.value = '';
    } else {
      console.error('Failed to add todo:', response.statusText);
    }
  } catch (error) {
    console.error('Error adding todo:', error);
  }
}

async function removeTodo(todo) {
  try {
    const response = await fetch(`${config.public.backendUrl}/${todo}`, {
      method: 'DELETE'
    });
    if (response.ok) {
      todos.value = todos.value.filter(t => t !== todo);
    } else {
      console.error('Failed to remove todo:', response.statusText);
    }
  } catch (error) {
    console.error('Error removing todo:', error);
  }
}
</script>
